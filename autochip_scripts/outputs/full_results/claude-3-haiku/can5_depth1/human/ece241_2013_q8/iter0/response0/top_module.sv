module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam SEQ1 = 2'b01;
localparam SEQ2 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == SEQ2 && x == 1'b1) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SEQ1;
            end
        end
        SEQ1: begin
            if (x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SEQ2;
            end
        end
        SEQ2: begin
            if (x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SEQ1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
