module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;  // A
    end else begin
        state <= next;
    end
end

always @(state or r) begin
    case (state)
        2'b00: begin  // A
            if (r[1]) begin
                next = 2'b01;  // B
            end else if (r[2]) begin
                next = 2'b10;  // C
            end else if (r[3]) begin
                next = 2'b11;  // D
            end else begin
                next = 2'b00;  // A
            end
        end
        2'b01: begin  // B
            if (r[1]) begin
                next = 2'b01;  // B
            end else begin
                next = 2'b00;  // A
            end
        end
        2'b10: begin  // C
            if (r[2]) begin
                next = 2'b10;  // C
            end else begin
                next = 2'b00;  // A
            end
        end
        2'b11: begin  // D
            if (r[3]) begin
                next = 2'b11;  // D
            end else begin
                next = 2'b00;  // A
            end
        end
    endcase
end

always @(state) begin
    case (state)
        2'b00: begin  // A
            g = 3'b000;
        end
        2'b01: begin  // B
            g = 3'b001;
        end
        2'b10: begin  // C
            g = 3'b010;
        end
        2'b11: begin  // D
            g = 3'b100;
        end
    endcase
end

endmodule
