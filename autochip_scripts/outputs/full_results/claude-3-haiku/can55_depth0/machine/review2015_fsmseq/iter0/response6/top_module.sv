module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the state register
    reg [2:0] state;

    // Define the states
    localparam S = 3'b000, S1 = 3'b001, S11 = 3'b011, S110 = 3'b110, Done = 3'b111;

    // Update the state on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            state <= S;
        end
        else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end
                    else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end
                    else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end
                    else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= Done;
                    end
                    else begin
                        state <= S;
                    end
                end
                Done: begin
                    state <= Done;
                end
                default: begin
                    state <= S;
                end
            endcase
        end
    end

    // Assign the output based on the current state
    always @(*) begin
        if (state == Done) begin
            start_shifting = 1'b1;
        end
        else begin
            start_shifting = 1'b0;
        end
    end

endmodule
