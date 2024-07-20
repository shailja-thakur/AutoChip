module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= 3'b000;
            z <= 0;
        end else begin
            case (state)
                3'b000:
                    if (x) begin
                        state <= 3'b001;
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
                        z <= 0;
                    end else begin
                        state <= 3'b000;
                    end
                3'b011:
                    if (x) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b100;
                    end
                3'b100:
                    if (x) begin
                        state <= 3'b101;
                        z <= 1;
                    end else begin
                        state <= 3'b100;
                    end
                3'b101:
                    if (x) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
            endcase
        end
    end

endmodule
