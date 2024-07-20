module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE   = 2'b00,
          FOUND_1 = 2'b01,
          FOUND_10 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case(state)
        IDLE: begin
            if(x) begin
                next_state = FOUND_1;
            end
        end
        FOUND_1: begin
            if(!x) begin
                next_state = FOUND_10;
            end else begin
                next_state = FOUND_1;
            end
        end
        FOUND_10: begin
            if(x) begin
                next_state = FOUND_1;
                z = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
