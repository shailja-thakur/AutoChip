module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 'b00;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'b00: begin // S
            if (x == 1'b0) begin
                next_state = 'b00;
            end else begin
                next_state = 'b01;
            end
        end
        'b01: begin // S1
            if (x == 1'b0) begin
                next_state = 'b10;
            end else begin
                next_state = 'b01;
            end
        end
        'b10: begin // S10
            if (x == 1'b0) begin
                next_state = 'b00;
            end else begin
                next_state = 'b01;
            end
        end
        default: begin
            next_state = 'b00;
        end
    endcase
end

always @(*) begin
    case (state)
        'b00: begin // S
            z = 1'b0;
        end
        'b01: begin // S1
            z = 1'b0;
        end
        'b10: begin // S10
            z = x;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
