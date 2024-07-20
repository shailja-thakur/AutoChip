module top_module(input clk, input reset, output shift_ena);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    state <= 3'b001;
                end
                3'b001: begin
                    state <= 3'b010;
                end
                3'b010: begin
                    state <= 3'b011;
                end
                3'b011: begin
                    state <= 3'b100;
                end
                default: begin
                    state <= 3'b100;
                end
            endcase
        end
    end

    always @(state) begin
        if (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) begin
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
