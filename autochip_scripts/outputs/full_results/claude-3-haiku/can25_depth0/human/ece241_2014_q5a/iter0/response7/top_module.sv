module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam IDLE = 2'b00;
localparam COMPUTE = 2'b01;
localparam COMPLEMENT = 2'b10;

reg [1:0] state, next_state;
reg [7:0] num, complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        case (state)
            IDLE: begin
                complement <= 8'b0;
                z <= 1'b0;
            end
            COMPUTE: begin
                if (num[7]) begin
                    next_state <= COMPLEMENT;
                    complement <= ~num + 1;
                end
                else begin
                    next_state <= IDLE;
                    z <= 1'b0;
                end
            end
            COMPLEMENT: begin
                z <= complement[0];
                complement <= {1'b0, complement[7:1]};
                if (complement == 8'b0) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = COMPUTE;
        COMPUTE: next_state = COMPUTE;
        COMPLEMENT: next_state = COMPLEMENT;
    endcase
end

endmodule
