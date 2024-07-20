module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] r_x;
reg [31:0] r_z;

// State definitions
parameter S_IDLE = 2'b00;
parameter S_CONVERT = 2'b01;
parameter S_STOP = 2'b10;

reg [1:0] state;
reg enable_conv;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_IDLE;
        enable_conv <= 1'b0;
        r_x <= 32'b0;
        r_z <= 32'b0;
    end else begin
        case (state)
            S_IDLE: begin
                if (!areset && x == 1'b1) begin
                    enable_conv <= 1'b1;
                    r_x <= {r_x[30:0], x};    // Shift in the new bit
                    r_z <= ~r_x + 32'b1;      // Compute 2's complement
                    state <= S_CONVERT;
                end
            end
            S_CONVERT: begin
                if (!areset && x == 1'b0 && enable_conv) begin
                    r_x <= {r_x[30:0], x};    // Shift in the new bit
                    r_z <= ~r_x + 32'b1;      // Compute 2's complement
                    state <= S_CONVERT;
                end else begin
                    enable_conv <= 1'b0;
                    state <= S_STOP;
                end
            end
            S_STOP: begin
                if (!areset && x == 1'b0) begin
                    enable_conv <= 1'b1;
                    state <= S_CONVERT;
                end
            end
        endcase
    end
end

assign z = r_z[0];

endmodule
