module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam FIRST_1 = 2'b01;
localparam SECOND_1 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= FIRST_1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            FIRST_1: begin
                z <= 1'b0;
                if (x) begin
                    next_state <= SECOND_1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SECOND_1: begin
                z <= 1'b1;
                if (x) begin
                    next_state <= FIRST_1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
