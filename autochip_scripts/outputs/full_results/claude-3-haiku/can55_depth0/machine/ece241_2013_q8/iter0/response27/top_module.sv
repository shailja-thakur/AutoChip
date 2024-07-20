module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 'b00;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'b00: begin // state S
            if (x == 0) begin
                next_state = 'b00;
            end else begin
                next_state = 'b01;
            end
        end
        'b01: begin // state S1
            if (x == 0) begin
                next_state = 'b10;
            end else begin
                next_state = 'b01;
            end
        end
        'b10: begin // state S10
            if (x == 0) begin
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
        'b00: begin // state S
            z = 0;
        end
        'b01: begin // state S1
            z = 0;
        end
        'b10: begin // state S10
            z = x;
        end
        default: begin
            z = 0;
        end
    endcase
end

endmodule
