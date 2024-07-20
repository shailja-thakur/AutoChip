module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Define the state assignments
parameter S0 = 3'b000;   // 000
parameter S1 = 3'b001;   // 001
parameter S2 = 3'b010;   // 010
parameter S3 = 3'b011;   // 011
parameter S4 = 3'b100;   // 100

// Define the next state assignments
parameter NS0_X0 = 3'b000;   // Next state for x=0, when current state is S0
parameter NS0_X1 = 3'b001;   // Next state for x=1, when current state is S0
parameter NS1_X0 = 3'b001;   // Next state for x=0, when current state is S1
parameter NS1_X1 = 3'b100;   // Next state for x=1, when current state is S1
parameter NS2_X0 = 3'b010;   // Next state for x=0, when current state is S2
parameter NS2_X1 = 3'b001;   // Next state for x=1, when current state is S2
parameter NS3_X0 = 3'b001;   // Next state for x=0, when current state is S3
parameter NS3_X1 = 3'b010;   // Next state for x=1, when current state is S3
parameter NS4_X0 = 3'b011;   // Next state for x=0, when current state is S4
parameter NS4_X1 = 3'b100;   // Next state for x=1, when current state is S4

// Define the output assignments
parameter O0 = 1'b0;   // Output when current state is S0
parameter O1 = 1'b0;   // Output when current state is S1
parameter O2 = 1'b0;   // Output when current state is S2
parameter O3 = 1'b1;   // Output when current state is S3
parameter O4 = 1'b1;   // Output when current state is S4

// Define the combinational logic for Y[0] and z
always @(posedge clk) begin
    case (y)
        S0: if (x) begin
                Y0 <= NS0_X1[0];
                z <= O0;
            end else begin
                Y0 <= NS0_X0[0];
                z <= O0;
            end
        S1: if (x) begin
                Y0 <= NS1_X1[0];
                z <= O1;
            end else begin
                Y0 <= NS1_X0[0];
                z <= O1;
            end
        S2: if (x) begin
                Y0 <= NS2_X1[0];
                z <= O2;
            end else begin
                Y0 <= NS2_X0[0];
                z <= O2;
            end
        S3: if (x) begin
                Y0 <= NS3_X1[0];
                z <= O3;
            end else begin
                Y0 <= NS3_X0[0];
                z <= O3;
            end
        S4: if (x) begin
                Y0 <= NS4_X1[0];
                z <= O4;
            end else begin
                Y0 <= NS4_X0[0];
                z <= O4;
            end
    endcase
end

endmodule
