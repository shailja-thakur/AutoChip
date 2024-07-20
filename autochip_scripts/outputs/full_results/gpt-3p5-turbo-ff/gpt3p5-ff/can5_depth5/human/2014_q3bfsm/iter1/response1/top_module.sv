module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y, next_y;
reg [2:0] y_next_state;
reg [1:0] x_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 3'b000;
    end else begin
        y <= next_y;
    end
end

always @(y or x) begin
    case (y)
        3'b000: begin
            if (x_state == 2'b00) begin
                next_y = 3'b001;
                z = 1'b0;
            end else if (x_state == 2'b01) begin
                next_y = 3'b000;
                z = 1'b0;
            end else if (x_state == 2'b10) begin
                next_y = 3'b000;
                z = 1'b0;
            end else begin
                next_y = 3'b000;
                z = 1'b0;
            end
        end
        3'b001: begin
            if (x_state == 2'b00) begin
                next_y = 3'b001;
                z = 1'b0;
            end else if (x_state == 2'b01) begin
                next_y = 3'b100;
                z = 1'b0;
            end else if (x_state == 2'b10) begin
                next_y = 3'b100;
                z = 1'b0;
            end else begin
                next_y = 3'b100;
                z = 1'b0;
            end
        end
        3'b010: begin
            if (x_state == 2'b00) begin
                next_y = 3'b001;
                z = 1'b0;
            end else if (x_state == 2'b01) begin
                next_y = 3'b001;
                z = 1'b0;
            end else if (x_state == 2'b10) begin
                next_y = 3'b001;
                z = 1'b0;
            end else begin
                next_y = 3'b001;
                z = 1'b0;
            end
        end
        3'b011: begin
            if (x_state == 2'b00) begin
                next_y = 3'b010;
                z = 1'b1;
            end else if (x_state == 2'b01) begin
                next_y = 3'b010;
                z = 1'b0;
            end else if (x_state == 2'b10) begin
                next_y = 3'b010;
                z = 1'b0;
            end else begin
                next_y = 3'b010;
                z = 1'b0;
            end
        end
        3'b100: begin
            if (x_state == 2'b00) begin
                next_y = 3'b100;
                z = 1'b1;
            end else if (x_state == 2'b01) begin
                next_y = 3'b100;
                z = 1'b1;
            end else if (x_state == 2'b10) begin
                next_y = 3'b100;
                z = 1'b1;
            end else begin
                next_y = 3'b011;
                z = 1'b1;
            end
        end
        default: begin
            next_y = 3'b000;
            z = 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        x_state <= 2'b00;
    end else begin
        x_state <= {x_state[0], x};
    end
end

endmodule
