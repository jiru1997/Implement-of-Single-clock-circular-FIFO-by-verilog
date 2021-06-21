`timescale 1ns/1ns
module single_clk_circular_fifo_tb;

	reg clk, rst, enable;
	reg wr, rd;
	reg [7:0] data_in;            
	wire [7:0] data_out;       
    wire empty, full;  

    integer i;

    single_clk_circular_fifo sccf (.clk(clk),
    	.rst(rst),
    	.enable(enable),
    	.data_in(data_in),
    	.data_out(data_out),
    	.wr(wr),
    	.rd(rd),
    	.empty(empty),
    	.full(full));

    always # 5 clk = ~ clk;

    initial begin

    	//$monitor("clk=0x%0b rst=0x%0b wr=0x%0b rd=0x%0b data_in=x%0d data_out=x%0d empty=0x%0b full=0x%0b" ,clk, rst, wr, rd, data_in, data_out, empty, full);

	clk <= 0;
	rst <= 1;
	enable <= 1;

    # 100;

    rst <= 0;

    @(posedge clk)
    for(i = 1; i <= 8; i = i + 1) begin
         @(posedge clk) begin
             wr <= 1;
             rd <= 0;
             data_in <= i;
         end
    end

    @(posedge clk)
    rd <= 1;
    wr <= 0;
    for(i = 1; i <= 9; i = i + 1) begin
         @(posedge clk) begin
             rd <= 1;
             wr <= 0;
         end
    end


    $stop;

    end



endmodule
