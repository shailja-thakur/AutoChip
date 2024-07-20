module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Reset to state B
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            2'b00: begin  // state A
                if (in) begin
                    next_state = 2'b00;  // Next state is A
                end else begin
                    next_state = 2'b01;  // Next state is B
                end
            end
            2'b01: begin  // state B
                if (in) begin
                    next_state = 2'b01;  // Next state is B
                end else begin
                    next_state = 2'b00;  // Next state is A
                end
            end
            default: begin
                next_state = 2'b01;  // Default next state is B
            end
        endcase
    end

    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
