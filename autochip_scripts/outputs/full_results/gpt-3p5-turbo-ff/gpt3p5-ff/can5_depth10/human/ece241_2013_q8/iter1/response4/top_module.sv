module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= 2'b00;
            z <= 0;
        end else begin
            case (state)
                2'b00:
                    if (x) begin
                        state <= 2'b01;
                    end
                2'b01:
                    if (x) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b00;
                    end
                2'b10:
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b11;
                        z <= 1;
                    end
                2'b11:
                    if (~x) begin
                        state <= 2'b00;
                    end
            endcase
        end
    end

endmodule
