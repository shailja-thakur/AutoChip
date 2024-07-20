module top_module (
    input clk,
    input reset,
    input in,
    output wire disc,
    output wire flag,
    output wire err);

    reg [2:0] state;
    reg disc_reg;
    reg flag_reg;
    reg err_reg;

    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case(state)
                3'b000: begin
                    if (in)
                        state <= 3'b001;
                end
                3'b001: begin
                    if (in)
                        state <= 3'b010;
                    else
                        state <= 3'b000;
                end
                3'b010: begin
                    if (in)
                        state <= 3'b011;
                    else
                        state <= 3'b000;
                end
                3'b011: begin
                    if (in)
                        state <= 3'b100;
                    else
                        state <= 3'b000;
                end
                3'b100: begin
                    if (in) begin
                        state <= 3'b101;
                        disc_reg <= 1'b1;
                    end
                    else begin
                        state <= 3'b110;
                        flag_reg <= 1'b1;
                    end
                end
                3'b101: begin
                    if (in)
                        state <= 3'b111;
                end
                3'b110: begin
                    if (in)
                        state <= 3'b010;
                end
                3'b111: begin
                    if (in) begin
                        state <= 3'b111;
                        err_reg <= 1'b1;
                    end
                    else
                        state <= 3'b000;
                end
            endcase
        end
    end

    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

endmodule
