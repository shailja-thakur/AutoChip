module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    wire out;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00;  // OFF state
        else begin
            case (state)
                2'b00: begin  // OFF state
                    if (j)
                        state <= 2'b01;  // Transition to ON state
                end
                2'b01: begin  // ON state
                    if (k)
                        state <= 2'b00;  // Transition to OFF state
                end
            endcase
        end
    end

    // Output logic
    always @* begin
        case (state)
            2'b00: out = 1'b0;  // OFF state, output is 0
            2'b01: out = 1'b1;  // ON state, output is 1
        endcase
    end

endmodule
