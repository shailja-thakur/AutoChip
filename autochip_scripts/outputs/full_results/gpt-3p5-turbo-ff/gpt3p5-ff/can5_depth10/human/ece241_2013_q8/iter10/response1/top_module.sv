module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [3:0] state;
    
    always @(negedge aresetn or posedge clk) begin
        if (~aresetn) begin
            state <= 4'b0000;
            z <= 0;
        end else begin
            case (state)
                4'b0000:
                    if (x) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0001:
                    if (x) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0010:
                    if (x) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0011:
                    if (x) begin
                        state <= 4'b0100;
                    end else if (!x) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0100:
                    if (x) begin
                        state <= 4'b0101;
                    end else if (!x) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                4'b0101:
                    if (!x) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0101;
                    end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 4'b0101) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end

endmodule
