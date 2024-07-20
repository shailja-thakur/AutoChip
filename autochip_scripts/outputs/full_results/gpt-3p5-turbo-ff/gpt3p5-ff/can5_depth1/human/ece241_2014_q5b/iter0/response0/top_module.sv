module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state;
reg q;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
            end
            2'b01: begin
                if (!x)
                    state <= 2'b10;
            end
            2'b10: begin
                if (x)
                    state <= 2'b01;
            end
        endcase
    end

always @(posedge clk) begin
    case (state)
        2'b00: begin
            q <= 1'b0;
            z <= 1'b0;
        end
        2'b01: begin
            q <= 1'b1;
            z <= 1'b1;
        end
        2'b10: begin
            q <= 1'b1;
            z <= 1'b0;
        end
    endcase
end

endmodule
