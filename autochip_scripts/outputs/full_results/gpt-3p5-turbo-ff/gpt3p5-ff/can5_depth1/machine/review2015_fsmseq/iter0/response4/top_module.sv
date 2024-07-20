module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    // State definition
    reg [2:0] state;
    
    // Next state logic
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 3'b000; // Initial state (S)
        else begin
            case (state)
                3'b000: // S state
                    if (data)
                        state <= 3'b001; // S1 state
                    else
                        state <= 3'b000;
                3'b001: // S1 state
                    if (data)
                        state <= 3'b011; // S11 state
                    else
                        state <= 3'b000;
                3'b011: // S11 state
                    if (data)
                        state <= 3'b011;
                    else
                        state <= 3'b110; // S110 state
                3'b110: // S110 state
                    if (data)
                        state <= 3'b111; // Done state
                    else
                        state <= 3'b000;
                3'b111: // Done state
                    state <= 3'b111;
            endcase
        end
    end
    
    // Output assignment
    assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
