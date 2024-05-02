module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [3:0] state;
    reg [1:0] shift_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            shift_count <= 0;
        end else begin
            case (state)
                0: begin
                    if (shift_ena) begin
                        state <= 1;
                        shift_count <= 4;
                    end else begin
                        state <= 0;
                     end
                end
                1: begin
                    if (shift_count == 0) begin
                        state <= 2;
                        shift_count <= 4;
                    end else begin
                        shift_count <= shift_count - 1;
                    end
                end
                2: begin
                    if (shift_count == 0) begin
                        state <= 3;
                        shift_count <= 4;
                    end else begin
                        shift_count <= shift_count - 1;
                    end
                end
                3: begin
                    if (shift_count == 0) begin
                        state <= 0;
                        shift_count <= 4;
                    end else begin
                        shift_count <= shift_count - 1;
                    end
                end
            endcase
        end
    end

    assign shift_ena = state == 1;

endmodule