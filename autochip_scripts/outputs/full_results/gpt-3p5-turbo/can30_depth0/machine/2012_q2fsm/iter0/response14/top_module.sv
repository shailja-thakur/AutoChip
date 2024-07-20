module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // initial state = A
        end else begin
            case (state)
                3'b000: begin // state A
                    if (w == 1'b0) begin
                        state <= 3'b000; // next state = A
                    end else begin
                        state <= 3'b001; // next state = B
                    end
                end
                3'b001: begin // state B
                    if (w == 1'b0) begin
                        state <= 3'b010; // next state = C
                    end else begin
                        state <= 3'b011; // next state = E
                    end
                end
                3'b010: begin // state C
                    if (w == 1'b0) begin
                        state <= 3'b010; // next state = C
                    end else begin
                        state <= 3'b101; // next state = F
                    end
                end
                3'b011: begin // state D
                    if (w == 1'b0) begin
                        state <= 3'b000; // next state = A
                    end else begin
                        state <= 3'b011; // next state = D
                    end
                end
                3'b100: begin // state E
                    if (w == 1'b0) begin
                        state <= 3'b011; // next state = D
                    end else begin
                        state <= 3'b100; // next state = E
                    end
                end
                3'b101: begin // state F
                    if (w == 1'b0) begin
                        state <= 3'b011; // next state = D
                    end else begin
                        state <= 3'b010; // next state = C
                    end
                end
            endcase
        end
    end

    assign z = (state == 3'b100) || (state == 3'b101);
    
endmodule
