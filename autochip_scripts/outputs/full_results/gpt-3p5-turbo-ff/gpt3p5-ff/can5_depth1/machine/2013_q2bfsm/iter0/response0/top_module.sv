module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

    reg [3:0] state;
    reg f;
    reg g;
    reg [1:0] next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 3'b0; // Initializing state to S0
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
            f <= (state == 3'b10) ? 1'b1 : 1'b0; // Setting f to 1 when state is B
            g <= (state == 3'b100 || state == 3'b101 || state == 3'b111) ? 1'b1 : 1'b0; // Setting g to 1 when state is G1 or G2 or P1
        end
    end

    always @* begin
        case (state)
            3'b000: next_state = x ? 3'b001 : 3'b000; // Transition from S0 to S1 or staying in S0 based on x
            3'b001: next_state = x ? 3'b001 : 3'b010; // Transition from S1 to S1 or to S10 based on x
            3'b010: next_state = x ? 3'b100 : 3'b000; // Transition from S10 to G1 or back to S0 based on x
            3'b100: next_state = y ? 3'b101 : 3'b110; // Transition from G1 to P1 or to G2 based on y
            3'b101: next_state = 3'b101; // Staying in P1
            3'b110: next_state = y ? 3'b101 : 3'b100; // Transition from G2 to P1 or back to G1 based on y
            3'b111: next_state = y ? 3'b101 : 3'b111; // Transition from P0 to P1 or staying in P0 based on y
            default: next_state = 3'b000; // Default transition
        endcase
    end

endmodule
