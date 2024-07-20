module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk) begin
        if (resetn == 0) begin
            state <= 2'b00; // state A
        end else begin
            state <= next_state;
        end
    end
    
    always @(state, r) begin
        case (state)
            2'b00: begin // state A
                next_state = ({r[1], r[2], r[3]} != 3'b000) ? 2'b10 : 2'b00;
            end
            2'b01: begin // state B
                next_state = (r[1] == 1'b1) ? 2'b01 : 2'b00;
            end
            2'b10: begin // state C
                next_state = (r[2] == 1'b1) ? 2'b10 : 2'b00;
            end
            2'b11: begin // state D
                next_state = (r[3] == 1'b1) ? 2'b11 : 2'b00;
            end
        endcase
    end
    
    always @(state) begin
        case (state)
            2'b00: begin // state A
                g = 3'b000;
            end
            2'b01: begin // state B
                g = 3'b001;
            end
            2'b10: begin // state C
                g = 3'b010;
            end
            2'b11: begin // state D
                g = 3'b100;
            end
        endcase
    end

endmodule
