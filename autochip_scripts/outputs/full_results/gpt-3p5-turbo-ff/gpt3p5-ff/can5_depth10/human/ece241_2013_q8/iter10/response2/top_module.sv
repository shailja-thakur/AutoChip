module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(negedge aresetn or posedge clk) begin
        if (~aresetn) begin
            state <= 3'b000;
            z <= 0;
        end else begin
            case (state)
                3'b000:
                    if (x) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                3'b001:
                    if (x) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                3'b010:
                    if (x) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b000;
                    end
                3'b011:
                    if (x) begin
                        state <= 3'b010;
                        z <= 1;
                    end else begin
                        state <= 3'b000;
                    end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state != 3'b011) begin
            z <= 0;
        end
    end

endmodule
