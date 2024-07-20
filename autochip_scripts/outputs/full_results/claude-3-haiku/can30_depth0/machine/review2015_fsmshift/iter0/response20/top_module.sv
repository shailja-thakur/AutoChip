module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // B0
            shift_ena <= 1'b1;
        end
        else begin
            case (state)
                3'b000: // B0
                    begin
                        state <= 3'b001; // B1
                        shift_ena <= 1'b1;
                    end
                3'b001: // B1
                    begin
                        state <= 3'b010; // B2
                        shift_ena <= 1'b1;
                    end
                3'b010: // B2
                    begin
                        state <= 3'b011; // B3
                        shift_ena <= 1'b1;
                    end
                3'b011: // B3
                    begin
                        state <= 3'b100; // Done
                        shift_ena <= 1'b1;
                    end
                3'b100: // Done
                    begin
                        state <= 3'b000; // B0
                        shift_ena <= 1'b0;
                    end
                default:
                    begin
                        state <= 3'b100; // Done
                        shift_ena <= 1'b0;
                    end
            endcase
        end
    end

endmodule
