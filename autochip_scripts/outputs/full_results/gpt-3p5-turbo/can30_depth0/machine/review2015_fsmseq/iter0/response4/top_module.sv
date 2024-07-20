module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state; // register to store the current state

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000; // reset to initial state (S)
        end else begin
            case (state)
                4'b0000: begin // S state
                    if (data) begin
                        state <= 4'b0001; // next state is S1
                    end else begin
                        state <= 4'b0000; // next state is S
                    end
                end
                4'b0001: begin // S1 state
                    if (data) begin
                        state <= 4'b0011; // next state is S11
                    end else begin
                        state <= 4'b0000; // next state is S
                    end
                end
                4'b0011: begin // S11 state
                    if (data) begin
                        state <= 4'b0011; // next state is S11
                    end else begin
                        state <= 4'b0110; // next state is S110
                    end
                end
                4'b0110: begin // S110 state
                    if (data) begin
                        state <= 4'b1111; // next state is Done
                    end else begin
                        state <= 4'b0000; // next state is S
                    end
                end
                4'b1111: begin // Done state
                    state <= 4'b1111; // next state is Done
                end
            endcase
        end
    end

    assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0; // set output high if state is Done, low otherwise

endmodule
