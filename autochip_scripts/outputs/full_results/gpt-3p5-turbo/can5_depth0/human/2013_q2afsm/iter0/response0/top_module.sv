module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state, next_state;  // FSM state and next state

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;

    // Define state transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Define next state logic
    always @(state, r) begin
        case (state)
            A: begin
                if (r[1] == 1'b1) begin
                    if (r[2] == 1'b1) begin
                        next_state = C;
                    end else if (r[3] == 1'b1) begin
                        next_state = D;
                    end else begin
                        next_state = B;
                    end
                end else if (r[2] == 1'b1) begin
                    next_state = C;
                end else if (r[3] == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (r[1] == 1'b1) begin
                    if (r[2] == 1'b1) begin
                        next_state = C;
                    end else if (r[3] == 1'b1) begin
                        next_state = D;
                    end else begin
                        next_state = B;
                    end
                end else if (r[2] == 1'b1) begin
                    next_state = C;
                end else if (r[3] == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            C: begin
                if (r[1] == 1'b1) begin
                    if (r[2] == 1'b1) begin
                        next_state = C;
                    end else if (r[3] == 1'b1) begin
                        next_state = D;
                    end else begin
                        next_state = B;
                    end
                end else if (r[2] == 1'b1) begin
                    next_state = C;
                end else if (r[3] == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (r[1] == 1'b1) begin
                    if (r[2] == 1'b1) begin
                        next_state = C;
                    end else if (r[3] == 1'b1) begin
                        next_state = D;
                    end else begin
                        next_state = B;
                    end
                end else if (r[2] == 1'b1) begin
                    next_state = C;
                end else if (r[3] == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end

    // Define the output logic
    always @(state) begin
        case (state)
            A: begin
                g[1] = 1'b0;
                g[2] = 1'b0;
                g[3] = 1'b0;
            end
            B: begin
                if (r[1] == 1'b1) begin
                    g[1] = 1'b1;
                end else begin
                    g[1] = 1'b0;
                end
                g[2] = 1'b0;
                g[3] = 1'b0;
            end
            C: begin
                g[1] = 1'b0;
                if (r[2] == 1'b1) begin
                    g[2] = 1'b1;
                end else begin
                    g[2] = 1'b0;
                end
                g[3] = 1'b0;
            end
            D: begin
                g[1] = 1'b0;
                g[2] = 1'b0;
                if (r[3] == 1'b1) begin
                    g[3] = 1'b1;
                end else begin
                    g[3] = 1'b0;
                end
            end
        endcase
    end

endmodule
