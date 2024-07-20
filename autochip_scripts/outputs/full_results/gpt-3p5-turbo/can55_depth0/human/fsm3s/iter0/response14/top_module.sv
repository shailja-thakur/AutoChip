module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    wire [1:0] next_state;
    reg out;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // State A
        end else begin
            state <= next_state;
        end
    end

    always @(state, in) begin
        case(state)
            2'b00: begin // State A
                if (in) begin
                    next_state = 2'b01; // State B
                end else begin
                    next_state = 2'b00; // State A
                end
                out = 1'b0;
            end
            2'b01: begin // State B
                if (in) begin
                    next_state = 2'b01; // State B
                end else begin
                    next_state = 2'b10; // State C
                end
                out = 1'b0;
            end
            2'b10: begin // State C
                if (in) begin
                    next_state = 2'b11; // State D
                end else begin
                    next_state = 2'b00; // State A
                end
                out = 1'b0;
            end
            2'b11: begin // State D
                if (in) begin
                    next_state = 2'b10; // State C
                end else begin
                    next_state = 2'b01; // State B
                end
                out = 1'b1;
            end
        endcase
    end

    assign out = out;

endmodule
