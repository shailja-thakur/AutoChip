module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    reg [1:0] state;
    reg prev_x;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= 2'b0;
            z <= 1'b0;
        end else begin
            case (state)
                0: begin
                    if (x == 1'b1 && prev_x == 1'b0)
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (x == 1'b0 && prev_x == 1'b1)
                        state <= 2;
                    else if (x == 1'b1 && prev_x == 1'b0)
                        state <= 1;
                    else
                        state <= 0;
                end
                2: begin
                    if (x == 1'b1 && prev_x == 1'b0)
                        state <= 1;
                    else
                        state <= 0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 2)
            z <= 1'b1;
        else
            z <= 1'b0;
    end

    always @(posedge clk) begin
        prev_x <= x;
    end
endmodule
