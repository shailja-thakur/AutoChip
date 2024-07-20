module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    reg [3:0] counter;
    reg enable;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            counter <= 4'b0000;
            shift_ena <= 1'b1;
            enable <= 1'b1;
        end else begin
            case (state)
                3'b000: begin
                    shift_ena <= enable;
                    if (enable) begin
                        counter <= counter + 4'b0001;
                        if (counter == 4'b1111) begin
                            state <= 3'b001;
                            enable <= 1'b0;
                        end
                    end else begin
                        state <= 3'b000;
                        counter <= 4'b0000;
                        enable <= 1'b1;
                    end
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
                3'b100: begin
                    state <= 3'b101;
                end
                3'b101: begin
                    state <= 3'b110;
                end
                3'b110: begin
                    state <= 3'b111;
                end
                3'b111: begin
                    state <= 3'b000;
                end
            endcase
        end
    end
endmodule
