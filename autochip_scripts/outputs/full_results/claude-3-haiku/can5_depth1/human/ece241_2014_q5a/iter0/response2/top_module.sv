module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state;
reg [7:0] data;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S0;
        data <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            S0: begin // Capture input bits
                data <= {data[6:0], x};
                if (x == 1'b1) begin
                    state <= S1;
                end
                z <= 1'b0;
            end
            S1: begin // Compute 2's complement
                data <= ~data + 1'b1;
                z <= data[7];
            end
        endcase
    end
end

endmodule
