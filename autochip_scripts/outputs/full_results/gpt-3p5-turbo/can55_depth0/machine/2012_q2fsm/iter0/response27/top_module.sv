module top_module (
    input wire clk,
    input wire reset,
    input wire w,
    output wire z
);
    
    reg [2:0] state;
    wire z_e, z_f;
    
    assign z_e = (state == 3'b100);
    assign z_f = (state == 3'b101);
    assign z = z_e | z_f;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b00;
        end else begin
            case (state)
                3'b000: begin
                    if (w)
                        state <= 3'b01;
                    else
                        state <= 3'b00;
                end
                3'b001: begin
                    if (w)
                        state <= 3'b10;
                    else
                        state <= 3'b11;
                end
                3'b010: begin
                    if (w)
                        state <= 3'b11;
                    else
                        state <= 3'b10;
                end
                3'b011: begin
                    if (w)
                        state <= 3'b00;
                    else
                        state <= 3'b01;
                end
                3'b100: begin
                    if (w)
                        state <= 3'b10;
                    else
                        state <= 3'b10;
                end
                3'b101: begin
                    if (w)
                        state <= 3'b10;
                    else
                        state <= 3'b10;
                end
            endcase
        end
    end
    
endmodule
