`timescale 1ns/1ps

module traffic_tb;

reg clk;
reg reset;

integer seconds = 0;

wire A_red, A_yellow, A_green;
wire B_red, B_yellow, B_green;
wire C_red, C_yellow, C_green;
wire D_red, D_yellow, D_green;


// DUT Instantiation
traffic_controller dut(
    .clk(clk),
    .reset(reset),

    .A_red(A_red),
    .A_yellow(A_yellow),
    .A_green(A_green),

    .B_red(B_red),
    .B_yellow(B_yellow),
    .B_green(B_green),

    .C_red(C_red),
    .C_yellow(C_yellow),
    .C_green(C_green),

    .D_red(D_red),
    .D_yellow(D_yellow),
    .D_green(D_green)
);


// Clock generation
always #5 clk = ~clk;


// Logical traffic time counter
always @(posedge clk)
begin
    if(reset)
        seconds = 0;
    else
        seconds = seconds + 1;
end


// Reset and simulation duration
initial begin
    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    // Run long enough for multiple cycles
    #4000;

    $finish;
end


// Generate waveform file
initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_tb);
end


// Print traffic status whenever lights change
always @(A_red or A_yellow or A_green or
         B_red or B_yellow or B_green or
         C_red or C_yellow or C_green or
         D_red or D_yellow or D_green)
begin
    $display("\n=================================");
    $display("Traffic Time = %0d sec", seconds);
    $display("State Timer  = %0d", dut.timer);

    if(A_green)       $display("Road A : GREEN");
    else if(A_yellow) $display("Road A : YELLOW");
    else              $display("Road A : RED");

    if(B_green)       $display("Road B : GREEN");
    else if(B_yellow) $display("Road B : YELLOW");
    else              $display("Road B : RED");

    if(C_green)       $display("Road C : GREEN");
    else if(C_yellow) $display("Road C : YELLOW");
    else              $display("Road C : RED");

    if(D_green)       $display("Road D : GREEN");
    else if(D_yellow) $display("Road D : YELLOW");
    else              $display("Road D : RED");

    $display("=================================\n");
end

endmodule