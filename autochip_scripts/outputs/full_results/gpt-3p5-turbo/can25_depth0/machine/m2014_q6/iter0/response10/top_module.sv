module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define parameter values for state encoding
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;
    // Define state and next_state signals
    reg [1:0] state, next_state;
  
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
  
    always @* begin
        case(state)
            A: begin
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end

            B: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end

            C: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end

            D: begin
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = F;
                end
            end

            E: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end

            F: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end

    // Output z is high when the state machine is in state E or F, low otherwise
    assign z = (state == E || state == F) ? 1'b1 : 1'b0;
  
endmodule
