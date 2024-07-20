module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

    reg [2:0] present_state, next_state;

    // State Assignments
    parameter [2:0]
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= S0;
        end else begin
            present_state <= next_state;
        end
    end

    always @* begin
        case (present_state)
            S0:
                if (x) begin
                    next_state = S1;
                    z = 0;
                end else begin
                    next_state = S0;
                    z = 0;
                end
            S1:
                if (x) begin
                    next_state = S4;
                    z = 0;
                end else begin
                    next_state = S2;
                    z = 0;
                end
            S2:
                if (x) begin
                    next_state = S1;
                    z = 0;
                end else begin
                    next_state = S0;
                    z = 0;
                end
            S3:
                if (x) begin
                    next_state = S2;
                    z = 1;
                end else begin
                    next_state = S1;
                    z = 0;
                end
            S4:
                if (x) begin
                    next_state = S3;
                    z = 1;
                end else begin
                    next_state = S4;
                    z = 1;
                end
        endcase
    end

endmodule
