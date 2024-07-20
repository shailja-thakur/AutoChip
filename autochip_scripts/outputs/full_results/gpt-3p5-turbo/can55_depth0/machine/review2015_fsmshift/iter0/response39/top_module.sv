module top_module(
    input clk,
    input reset,
    output reg shift_ena,
    output reg [2:0] state);

    always @(posedge clk) begin
        if (reset == 1) begin
            state <= 3'b0; // B0
            shift_ena <= 1;
        end else begin
            case (state)
                3'b0: begin // B0
                    state <= 3'b1; // B1
                    shift_ena <= 1;
                end
                3'b1: begin // B1
                    state <= 3'b10; // B2
                    shift_ena <= 1;
                end
                3'b10: begin // B2
                    state <= 3'b11; // B3
                    shift_ena <= 1;
                end
                3'b11: begin // B3
                    state <= 3'b100; // Done
                    shift_ena <= 1;
                end
                default: begin // Done
                    state <= 3'b100;
                    shift_ena <= 0;
                end
            endcase
        end
    end
endmodule
