vlib work
vmap work work

vlog -work work single_clk_circular_fifo.v
vlog -work work single_clk_circular_fifo_tb.v

vsim -novopt work.single_clk_circular_fifo_tb
add wave -position insertpoint sim:/single_clk_circular_fifo_tb/*

run -all
