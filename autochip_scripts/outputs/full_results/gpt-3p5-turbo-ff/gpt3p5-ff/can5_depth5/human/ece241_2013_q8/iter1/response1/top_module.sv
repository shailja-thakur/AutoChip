module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

always @(state or x) begin
    case (state)
        3'b000: begin // state 0
            if (x == 1'b1) begin
                next_state = 3'b001;
                z <= 1'b0;
            end else begin
                next_state = 3'b000;
                z <= 1'b0;
            end
        end
        3'b001: begin // state 1
            if (x == 1'b0) begin
                next_state = 3'b010;
                z <= 1'b0;
            end else if (x == 1'b1) begin
                next_state = 3'b001;
                z <= 1'b0;
            end else begin
                next_state = 3'b000;
                z <= 1'b0;
            end
        end
        3'b010: begin // state 2
            if (x == 1'b1) begin
                next_state = 3'b011;
                z <= 1'b0;
            end else begin
                next_state = 3'b010;
                z <= 1'b0;
            end
        end
        3'b011: begin // state 3
            if (x == 1'b0) begin
                next_state = 3'b010;
                z <= 1'b0;
            end else if (x == 1'b1) begin
                next_state = 3'b001;
                z <= 1'b1;
            end else begin
                next_state = 3'b000;
                z <= 1'b0;
            end
        end
        default: begin
            next_state = 3'b000;
            z <= 1'b0;
        end
    endcase
end

endmodule
