module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00; // State A
        else begin
            case (state)
                2'b00: begin // State A
                    if (j)
                        state <= 2'b01; // Transition to State B
                    else
                        state <= 2'b00; // Stay in State A
                end
                2'b01: begin // State B
                    if (k)
                        state <= 2'b00; // Transition to State A
                    else
                        state <= 2'b01; // Stay in State B
                end
                default: state <= 2'b00; // Default case, initialize to State A
            endcase
        end
    end

    always @(state) begin
        if (state == 2'b01) // State B
            out <= 1'b1;  // Output is high
        else // State A
            out <= 1'b0; // Output is low
    end
    
endmodule
