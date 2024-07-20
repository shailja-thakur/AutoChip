module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [3:0] count;
    reg [1:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
            shift_ena <= 1;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (count < 3) begin
                        count <= count + 1;
                        shift_ena <= 1;
                    end else begin
                        count <= 0;
                        shift_ena <= 0;
                        state <= 1;
                    end
                end
                
                1: begin
                    if (count == 0) begin
                        shift_ena <= 0;
                        state <= 0;
                    end else begin
                        count <= count - 1;
                        shift_ena <= 1;
                    end
                end
            endcase
        end
    end

endmodule
