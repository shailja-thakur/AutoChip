module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg disc_reg;
    reg flag_reg;
    reg err_reg;

    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 3'd0;
        else begin
            case(state)
                3'd0: begin
                    if (in)
                        state <= 3'd1;
                end
                3'd1: begin
                    if (in)
                        state <= 3'd2;
                    else
                        state <= 3'd0;
                end
                3'd2: begin
                    if (in)
                        state <= 3'd3;
                end
                3'd3: begin
                    if (in)
                        state <= 3'd4;
                    else
                        state <= 3'd0;
                end
                3'd4: begin
                    if (in)
                        state <= 3'd5;
                    else
                        state <= 3'd0;
                end
                3'd5: begin
                    if (in) begin
                        state <= 3'd6;
                        disc_reg <= 1'b1;
                    end
                    else begin
                        state <= 3'd0;
                        flag_reg <= 1'b1;
                    end
                end
                3'd6: begin
                    if (in)
                        state <= 3'd7;
                    else
                        state <= 3'd0;
                end
                3'd7: begin
                    if (in) begin
                        state <= 3'd7;
                        err_reg <= 1'b1;
                    end
                    else
                        state <= 3'd0;
                end
            endcase
        end
    end

    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

endmodule
