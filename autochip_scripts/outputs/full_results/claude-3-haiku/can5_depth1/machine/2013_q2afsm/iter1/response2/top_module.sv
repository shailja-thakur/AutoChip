module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00; // State A
    end else begin
        state <= next;
    end
end

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (r[0]) begin
                next = 2'b01; // State B
            end else if (r[1]) begin
                next = 2'b10; // State C
            end else if (r[2]) begin
                next = 2'b11; // State D
            end else begin
                next = 2'b00; // State A
            end
        end
        2'b01: begin // State B
            if (r[0]) begin
                next = 2'b01; // State B
            end else begin
                next = 2'b00; // State A
            end
        end
        2'b10: begin // State C
            if (r[1]) begin
                next = 2'b10; // State C
            end else begin
                next = 2'b00; // State A
            end
        end
        2'b11: begin // State D
            if (r[2]) begin
                next = 2'b11; // State D
            end else begin
                next = 2'b00; // State A
            end
        end
        default: begin
            next = 2'b00; // State A
        end
    endcase
end

always @(*) begin
    case (state)
        2'b01: begin // State B
            g = 3'b010;
        end
        2'b10: begin // State C
            g = 3'b100;
        end
        2'b11: begin // State D
            g = 3'b001;
        end
        default: begin // State A
            g = 3'b000;
        end
    endcase
end

endmodule
