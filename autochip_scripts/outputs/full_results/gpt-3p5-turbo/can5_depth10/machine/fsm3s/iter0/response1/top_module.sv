module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define the states as constants
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state_reg;
reg [1:0] next_state;

// Assign initial state
initial begin
    state_reg = A;
    next_state = A;
end

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg <= A;
    end else begin
        state_reg <= next_state;
    end
end

// State transition logic
always @(*) begin
    case(state_reg)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

// Output logic
assign out = (state_reg == D) ? 1'b1 : 1'b0;

endmodule
