module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // initial state A
            out <= 1'b0; // out is 0 in all states except D
        end
        else begin
            state <= next_state; // state transition
            case (state)
                2'b00: begin // state A
                    if (in) begin
                        next_state = 2'b01; // state B
                    end
                    else begin
                        next_state = 2'b00; // state A
                    end
                    out <= 1'b0;
                end
                
                2'b01: begin // state B
                    if (in) begin
                        next_state = 2'b01; // state B
                    end
                    else begin
                        next_state = 2'b10; // state C
                    end
                    out <= 1'b0;
                end
                
                2'b10: begin // state C
                    if (in) begin
                        next_state = 2'b11; // state D
                    end
                    else begin
                        next_state = 2'b00; // state A
                    end
                    out <= 1'b0;
                end
                
                2'b11: begin // state D
                    if (in) begin
                        next_state = 2'b01; // state B
                    end
                    else begin
                        next_state = 2'b10; // state C
                    end
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
