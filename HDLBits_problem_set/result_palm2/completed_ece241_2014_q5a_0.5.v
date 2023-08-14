module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter STATE_IDLE = 1'b0;
    parameter STATE_SHIFTING = 1'b1;
    parameter STATE_COMPLETING = 1'b2;

    reg [1:0] state;
    reg [15:0] x_reg;
    reg [15:0] z_reg;

    wire [15:0] x_in;
    wire [15:0] z_out;

    always @(posedge clk) begin
        if (areset) begin
            state <= STATE_IDLE;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (x) begin
                        state <= STATE_SHIFTING;
                        x_reg <= x;
                        z_reg <= 0;
                    end
                end
                STATE_SHIFTING: begin
                    z_reg <= z_reg << 1;
                    if (x_reg[15]) begin
                        z_reg[15] <= 1;
                    end else begin
                        z_reg[15] <= 0;
                    end
                    z_reg[14:0] <= z_reg[14:0] + x_reg[14:0];
                    if (x_reg[14]) begin
                        state <= STATE_COMPLETING;
                    end
                end
                STATE_COMPLETING: begin
                    state <= STATE_IDLE;
                end
            endcase
        end
    end

    assign x_in = x_reg[15:0];
    assign z_out = z_reg[15:0];

endmodule