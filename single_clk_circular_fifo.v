`timescale 1ns/1ns
module single_clk_circular_fifo( clk, rst, enable, data_in, data_out, wr, rd, empty, full);

	parameter Data_width = 8;
	parameter FIFO_depth = 8;
	parameter Buf_width =  $clog2(Data_width);

	input clk, rst, enable;
	input wr,rd;
	input [Data_width - 1: 0] data_in;             
	output reg [Data_width - 1: 0] data_out;      
	output wire empty,full;                   
	
	reg [Buf_width : 0] fifo_cnt = 0;         
	reg [Buf_width - 1 : 0] rd_ptr = 0,wr_ptr = 0;     
	reg [FIFO_depth - 1 : 0] buf_mem[Data_width - 1 : 0];

	assign empty = (fifo_cnt == 0); 
	assign full  = (fifo_cnt == FIFO_depth);
	
	always @(posedge clk or posedge rst) begin 
 
		if(rst) begin
			data_out <= 'bx;
			rd_ptr <= 0;
		end
		else if(!enable)
			data_out <= 0;
		else if(rd && !empty) begin
			data_out <= buf_mem[rd_ptr];
			rd_ptr <= rd_ptr + 1;
			fifo_cnt <= fifo_cnt - 1;
		end
		else begin
			data_out <= 'bx;
		end
	end
	

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			wr_ptr <= 0;
		end
		else if(!enable)
		    buf_mem[wr_ptr] <= buf_mem[wr_ptr];
		else if(wr && !full) begin
			buf_mem[wr_ptr] <= data_in;
			wr_ptr <= wr_ptr + 1;
			fifo_cnt <= fifo_cnt + 1;
		end
		else begin
			buf_mem[wr_ptr] <= buf_mem[wr_ptr];
		end
	end
	
endmodule 
