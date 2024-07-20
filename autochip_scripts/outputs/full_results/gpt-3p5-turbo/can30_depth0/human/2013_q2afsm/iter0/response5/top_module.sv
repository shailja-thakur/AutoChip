module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define the state codes
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

// Define the state register
reg [1:0] state_reg;
reg [1:0] state_next;

// Define the output registers
reg [3:1] g_reg;
reg [3:1] g_next;

// Define the next state and output logic using always block
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state_reg <= A;
        g_reg <= 0;
    end
    else begin
        state_reg <= state_next;
        g_reg <= g_next;
    end
end

// Define the state transition and output logic using always block
always @(state_reg, r) begin
    case (state_reg)
        A: begin
               if (r[1]) begin
                   state_next = B;
                   g_next = 4'b0001;
               end
               else if (r[2]) begin
                   state_next = C;
                   g_next = 4'b0010;
               end
               else if (r[3]) begin
                   state_next = D;
                   g_next = 4'b0100;
               end
               else begin
                   state_next = A;
                   g_next = 4'b0000;
               end
           end
        B: begin
               if (r[1]) begin
                   state_next = B;
                   g_next = 4'b0001;
               end
               else begin
                   state_next = A;
                   g_next = 4'b0000;
               end
           end
        C: begin
               if (r[2]) begin
                   state_next = C;
                   g_next = 4'b0010;
               end
               else begin
                   state_next = A;
                   g_next = 4'b0000;
               end
           end
        D: begin
               if (r[1] || r[2] || r[3]) begin
                   state_next = D;
                   g_next = 4'b0100;
               end
               else begin
                   state_next = A;
                   g_next = 4'b0000;
               end
           end
    endcase
end

// Assign the output registers to the module outputs
assign g = g_reg;
endmodule
