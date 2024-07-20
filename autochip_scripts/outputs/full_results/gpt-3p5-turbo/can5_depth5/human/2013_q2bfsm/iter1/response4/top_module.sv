module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [1:0] state;
    reg [2:0] x_count;
    reg [1:0] y_count;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00; // state A
            f <= 1'b0;
            g <= 1'b0;
            x_count <= 3'b000;
            y_count <= 2'b00;
        end
        else begin
            case (state)
                2'b00: begin // state A
                    f <= 1'b0;
                    g <= 1'b0;
                    
                    if (resetn) begin
                        state <= 2'b01; // transition to state B
                        x_count <= 3'b000;
                    end
                end
                2'b01: begin // state B
                    if (x == 1'b1)
                        x_count <= x_count + 1;
                    else
                        x_count <= 3'b000;
                    
                    if (x_count == 3'b111)
                        state <= 2'b10; // transition to state C
                end
                2'b10: begin // state C
                    if (x == 1'b0) begin
                        state <= 2'b01; // transition back to state B
                        x_count <= 3'b000;
                    end
                    else begin
                        if (y == 1'b1) begin
                            state <= 2'b11; // transition to state D
                            y_count <= 2'b00;
                        end
                    end
                end
                2'b11: begin // state D
                    if (y == 1'b1)
                        y_count <= y_count + 1;
                    
                    if (y_count >= 2) begin
                        if (y != 1'b1) begin
                            state <= 2'b01; // transition back to state B
                            y_count <= 2'b00;
                        end
                    end
                    else begin
                        if (y == 1'b1)
                            state <= 2'b11; // stay in state D
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00, 2'b01: g <= 1'b0; // g = 0 in states A and B
            2'b10, 3'b11: g <= 1'b1; // g = 1 in states C and D
        endcase
    end
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            f <= 1'b0;
        else begin
            case (state)
                2'b01: f <= 1'b1; // set f to 1 for one clock cycle in state B
                default: f <= 1'b0;
            endcase
        end
    end
endmodule
