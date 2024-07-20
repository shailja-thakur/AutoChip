module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b1; // Reset to state B
        end else begin
            state <= next_state;
        end
    end

    always @(state or in) begin
        case (state)
            2'b00: begin // State A
                if (in) begin
                    next_state = 2'b00; // Next state is A
                end else begin
                    next_state = 2'b01; // Next state is B
                end
            end

            2'b01: begin // State B
                if (in) begin
                    next_state = 2'b01; // Next state is B
                end else begin
                    next_state = 2'b00; // Next state is A
                end
            end
        endcase
    end

    assign out = (state == 2'b01); // out is high when the state is B, low otherwise

endmodule
