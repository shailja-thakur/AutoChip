module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000; // initial state is S
        end else begin
            state <= next_state; // update state based on next state
        end
    end
    
    always @(state, data) begin
        case (state)
            4'b0000: begin // S
                if (data) begin // high data input
                    next_state = 4'b0001; // next state is S1
                end else begin // low data input
                    next_state = 4'b0000; // next state is S
                end
            end
            4'b0001: begin // S1
                if (data) begin // high data input
                    next_state = 4'b0011; // next state is S11
                end else begin // low data input
                    next_state = 4'b0000; // next state is S
                end
            end
            4'b0011: begin // S11
                if (data) begin // high data input
                    next_state = 4'b0011; // next state is S11
                end else begin // low data input
                    next_state = 4'b0110; // next state is S110
                end
            end
            4'b0110: begin // S110
                if (data) begin // high data input
                    next_state = 4'b1111; // next state is Done
                end else begin // low data input
                    next_state = 4'b0000; // next state is S
                end
            end
            4'b1111: begin // Done
                next_state = 4'b1111; // next state is Done
            end
            default: begin // default case
                next_state = 4'b0000; // next state is S
            end
        endcase
    end
    
    assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0; // output is high if state is Done, low otherwise

endmodule
