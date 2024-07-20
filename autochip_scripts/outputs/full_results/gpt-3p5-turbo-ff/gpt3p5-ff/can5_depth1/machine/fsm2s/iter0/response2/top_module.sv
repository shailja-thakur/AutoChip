module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // Initializing state to A
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            2'b00: begin // State A
                if(j) begin
                    next_state = 2'b01; // Transition to state B if j is high
                end else begin
                    next_state = 2'b00; // Stay in state A if j is low
                end
            end
            2'b01: begin // State B
                if(k) begin
                    next_state = 2'b00; // Transition to state A if k is high
                end else begin
                    next_state = 2'b01; // Stay in state B if k is low
                end
            end
            default: next_state = 2'b00; // default state is A
        endcase
    end

    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, low otherwise

endmodule
