module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;
    reg [7:0] pattern;
    reg [2:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            shift_ena <= 1; // assert shift_ena for 4 cycles
            count <= 0;
        end else begin
            case(state)
                0: begin
                    shift_ena <= 0; // 0 forever (until reset)
                    if (pattern == 8'b01010101) begin
                        state <= 1;
                        count <= 0;
                    end
                end

                1: begin
                    if (count < 3) begin
                        count <= count + 1;
                    end else begin
                        count <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            pattern <= 0;
        end else begin
            pattern <= {pattern[6:0], shift_ena};
        end
    end

endmodule
