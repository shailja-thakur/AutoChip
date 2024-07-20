module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    wire z_temp;
    
    // state A
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (x) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b10;
                    end
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    // output z
    assign z_temp = (state == 2'b01) ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            z <= z_temp;
        end
    end
    
endmodule
