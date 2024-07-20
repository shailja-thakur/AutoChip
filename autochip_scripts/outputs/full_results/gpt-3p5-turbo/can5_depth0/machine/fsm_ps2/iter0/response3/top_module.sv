module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state;
    reg done_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // initial state is BYTE1
        end else begin
            case (state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1) begin
                        state <= 2'b01; // transition to BYTE2 state
                    end
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // transition to BYTE3 state
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // transition to DONE state
                end
                2'b11: begin // DONE state
                    if (in[2] == 1'b0) begin
                        state <= 2'b00; // transition back to BYTE1 state
                    end else begin
                        state <= 2'b01; // transition back to BYTE2 state
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done_reg <= 1'b0;
        end else begin
            if (state == 2'b11) begin // DONE state
                done_reg <= 1'b1;
            end else begin
                done_reg <= 1'b0;
            end
        end
    end
    
    assign done = done_reg;
    
endmodule
