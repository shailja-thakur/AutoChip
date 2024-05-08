module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [1:0] state;
    reg [3:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counter <= 0;
        end else begin
            case (state)
                0: begin
                    if (shift_ena) begin
                        state <= 1;
                        counter <= 4;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (counter == 0) begin
                        state <= 2;
                    end else begin
                        counter <= counter - 1;
                    end
                end
                2: begin
                    state <= 0;
                end
            endcase
        end
    end

    assign shift_ena = state == 1;

endmodule