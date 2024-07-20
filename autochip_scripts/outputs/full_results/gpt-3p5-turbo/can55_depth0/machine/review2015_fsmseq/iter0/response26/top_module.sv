module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [2:0] state;
    always @(posedge clk) begin
        if (reset)
            state <= 3'b0; // Initial State is S
        else begin
            case (state)
                3'b000: begin // State S
                    if (data) 
                        state <= 3'b001; // Next State is S1 if data input is high
                    else
                        state <= 3'b000; // Next State is S if data input is low
                end
                3'b001: begin // State S1
                    if (data) 
                        state <= 3'b011; // Next State is S11 if data input is high
                    else
                        state <= 3'b000; // Next State is S if data input is low
                end
                3'b011: begin // State S11
                    if (data) 
                        state <= 3'b011; // Next State is S11 if data input is high
                    else
                        state <= 3'b110; // Next State is S110 if data input is low
                end
                3'b110: begin // State S110
                    if (data) 
                        state <= 3'b111; // Next State is Done if data input is high
                    else
                        state <= 3'b000; // Next State is S if data input is low
                end
                3'b111: // State Done
                    state <= 3'b111; // Next State is Done
            endcase
        end
    end

    always @(state) begin
        if (state == 3'b111) // State is Done
            start_shifting <= 1'b1; // Output is high
        else
            start_shifting <= 1'b0; // Output is low
    end

endmodule
